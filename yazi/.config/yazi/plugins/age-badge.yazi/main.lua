--- @sync entry
-- Age badge: a colored chip next to each file whose hue runs red (just modified)
-- through the spectrum to violet (long ago). Inspired by OneCommander.
--
-- setup() options:
--   position = "left" (before icon/name, default) | "right" (after the size)
--   pad      = add a blank cell on the badge's outer edge (left for "left",
--              right for "right")
--   compact  = true (default) for a 3-cell chip, false to widen it to 5 cells

local DAY   = 86400
local MONTH = 30 * DAY
local YEAR  = 365 * DAY

-- HSV -> RGB; returns a "#rrggbb" string plus perceived luminance (0..1).
local function hsv_to_color(hue, saturation, value)
	local chroma = value * saturation
	local second = chroma * (1 - math.abs((hue / 60) % 2 - 1))
	local base = value - chroma
	local red, green, blue
	if hue < 60 then
		red, green, blue = chroma, second, 0
	elseif hue < 120 then
		red, green, blue = second, chroma, 0
	elseif hue < 180 then
		red, green, blue = 0, chroma, second
	elseif hue < 240 then
		red, green, blue = 0, second, chroma
	elseif hue < 300 then
		red, green, blue = second, 0, chroma
	else
		red, green, blue = chroma, 0, second
	end
	red, green, blue = red + base, green + base, blue + base
	local luminance = 0.299 * red + 0.587 * green + 0.114 * blue
	return string.format("#%02x%02x%02x",
		math.floor(red * 255 + 0.5), math.floor(green * 255 + 0.5), math.floor(blue * 255 + 0.5)), luminance
end

-- Linear interpolation, clamped, mapping age in [low, high) onto [from, to].
local function lerp(age, low, high, from, to)
	local ratio = (age - low) / (high - low)
	if ratio < 0 then ratio = 0 elseif ratio > 1 then ratio = 1 end
	return from + (to - from) * ratio
end

-- Map age onto a hue: red->orange in the first day, racing through
-- yellow/green/cyan to blue within a week, blue to violet over the year, then
-- on into magenta beyond a year. Continuous, no hue jumps.
local function age_style(age)
	if age < DAY then
		return lerp(age, 0, DAY, 0, 30), 0.68     -- red -> orange
	elseif age < 8 * DAY then
		return lerp(age, DAY, 8 * DAY, 30, 180), 0.68 -- orange -> cyan
	elseif age < YEAR then
		return lerp(age, 8 * DAY, YEAR, 180, 270), 0.68 -- cyan -> violet
	else
		return lerp(age, YEAR, 10 * YEAR, 270, 320), 0.68
	end -- violet -> magenta
end

-- Compact age label: single uppercase unit letter, at most two digits.
-- Minutes and months share "M" but are told apart by hue (orange vs blue).
local function readable_age(age)
	if age < 60 then
		return string.format("%dS", age)    -- 0..59
	elseif age < 3600 then
		return string.format("%dM", age // 60) -- 1..59
	elseif age < DAY then
		return string.format("%dH", age // 3600) -- 1..23
	elseif age < 61 * DAY then
		return string.format("%dD", age // DAY) -- 1..60
	elseif age < YEAR then
		return string.format("%dM", age // MONTH) -- 2..12
	else
		local years = age // YEAR
		return string.format("%dY", years > 99 and 99 or years)
	end
end

-- Pad text to width with space on both sides; any odd cell goes to the left,
-- so the label sits just right of center rather than flush to an edge.
local function pad_sides(text, width)
	local slack = width - #text
	if slack <= 0 then return text end
	local right = slack // 2
	return string.rep(" ", slack - right) .. text .. string.rep(" ", right)
end

-- Build the colored age chip for a file, or a blank pad if mtime is unknown.
-- width is the total cell count; extra cells become colored padding.
local function chip(file, width)
	local cha = file.cha
	local mtime = math.floor(cha and cha.mtime or 0)
	if mtime == 0 then return ui.Span(string.rep(" ", width)) end

	local age = math.floor(ya.time() - mtime)
	if age < 0 then age = 0 end

	local hue, saturation = age_style(age)
	local background = hsv_to_color(hue, saturation, 0.88)
	return ui.Span(pad_sides(readable_age(age), width)):fg("#11111b"):bg(background)
end

return {
	setup = function(_, opts)
		opts = opts or {}
		local pad = opts.pad and true or false
		-- compact (default) is a snug 3-cell chip; otherwise widen to 5 cells.
		local width = opts.compact == false and 5 or 3

		if opts.position == "right" then
			-- order > Linemode's own padding (2000) puts the chip last, flush to the
			-- column edge; that built-in padding then separates it from the size.
			-- pad adds the optional trailing space on the outer (right) edge.
			Linemode:children_add(function(self)
				local parts = { chip(self._file, width) }
				if pad then parts[#parts + 1] = ui.Span(" ") end
				return ui.Line(parts)
			end, 2500)
		else
			-- order < padding (1000) places the chip at the very start, before the
			-- icon; pad sits on its left, the leading edge.
			Entity:children_add(function(self)
				local parts = {}
				if pad then parts[#parts + 1] = ui.Span(" ") end
				parts[#parts + 1] = chip(self._file, width)
				return ui.Line(parts)
			end, 500)
		end
	end,
}
