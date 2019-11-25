function weather
	if contains "full" $argv
		curl wttr.in/Laramie
	else if contains "small" $argv
		curl wttr.in/Laramie\?qn
	else if contains "astro" $argv
		curl v2.wttr.in/Laramie
	else if contains "line" $argv
		curl wttr.in/Laramie\?format=%C+%t+%w
	else
		curl wttr.in/Laramie\?0q
	end
end