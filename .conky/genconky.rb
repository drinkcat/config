#!/usr/bin/ruby

$l=["", "", ""]

def add(offset, text, voffset=nil)
	pre = voffset ? "${voffset #{voffset}}" : ""
	post = voffset ? "${voffset -#{voffset}}" : ""
	$l = $l.zip(text).map{|x|
		if (!x[1] || x[1] == "") then
			x[0]
		else
			x[0] + "${goto #{offset}}" + pre + x[1] + post
		end
	}
end

offset = 0
add(0, [
  "${color #ffcb48}$nodename$color ${color #98c2c7}$sysname$color",
  "${color #98c2c7}$kernel$color"
])

offset = 210

(1..8).each{|cpu|
	add(offset-3, [nil, nil,
"${cpugraph cpu#{cpu} 50,100 78af78 a3a3a3}"
])
	add(offset, [
"${cpu cpu#{cpu}}%",
"${freq_g #{cpu}}"
]);
	offset += 100
}

offset += 10
add(offset, [
"${color #ffcb48}RAM$color",
"${color #d00000}Swap$color",
""])

offset+=55
add(offset, [nil, nil,
"${voffset 0}${color #ffcb48}${membar 15,100}$color"], 10)
add(offset, [nil, nil,
"${color #d00000}${swapbar 15,100}$color"], 39)

# FIXME top ram/cpu processes

offset += 110

baseoffset = offset

["wlp6s0", "enp0"].each{|int|

offset = baseoffset

add(offset, [
	"${if_empty ${exec ~/.conky/net #{int} }}${color #ffcb48}#{int}$color",
	"${if_empty ${exec ~/.conky/net #{int} }}",
	"${if_empty ${exec ~/.conky/net #{int} }}"
])

offset += 80
add(offset-3, [nil, nil, "${color #98c2c7}${downspeedgraph #{int} 50,120 60af60 606060}$color"])

add(offset, [
	"${color #ffffff}${totaldown #{int}}$color",
	"${color #ffffff}${downspeed #{int}}$color"
]);

offset += 100
add(offset, ["${color #98c2c7}D$color"])

offset += 20
add(offset-3, [nil, nil, "${color #98c2c7}${upspeedgraph #{int} 50,120 60af60 606060}$color"])
add(offset, [
	"${color #ffffff}${totalup #{int}}$color",
	"${color #ffffff}${upspeed #{int}}$color"
]);

offset += 100
add(offset, ["${color #98c2c7}U$color${endif}", "${endif}", "${endif}"])

}

#FIXME: Add wired interface

offset += 30

add(offset, [
	"${color #98c2c7}Vol: ${execpi 2 ~/bin/snd status }$color",
	"${execpi 2 xkb-switch }"
]);

offset += 110

add(offset, [
	"${color #ffcb48}${execpi 2 ~/.conky/bat energy }$color"
]);

offset += 100

add(offset, [
	"${color #98c2c7}${execpi 2 ~/.conky/bat voltage }$color",
	"${color #98c2c7}${execpi 2 ~/.conky/bat power }$color"
]);

#FIXME: Weather

#FIXME: Mail notification

add(1000, [" "," "])

f = File.open(".conkyrc", "w")

f.puts <<END
background no
use_xft yes
xftfont DejaVu Sans Mono:size=6

update_interval 2.5
total_run_times 0
# the next two lines are very important, without them i3 won't give space for conky
own_window yes
own_window_type dock
own_window_transparent no
double_buffer yes
# I use the next two lines to make the conky line a
# thin as possible to waste as little space as possible
border_inner_margin 0
border_outer_margin 0
#use_spacer left
minimum_size 3000 62
maximum_width 2000
border_width 0
TEXT
END

f.print "${voffset 0}" + $l[2]
f.puts "${voffset 10}" + $l[0]
f.print "${voffset -50}" + $l[1]
f.close
