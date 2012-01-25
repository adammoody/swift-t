
# Flex ADLB data store with container_insert and container_size
# No real Turbine data flow here

package require turbine 0.0.1

namespace import turbine::string_*

turbine::defaults
turbine::init $engines $servers

if { ! [ adlb::amserver ] } {

    set c [ adlb::unique ]
    adlb::create $c container integer

    puts "loop"
    set iterations [ expr 5 + $c ]
    for { set i [ expr $c + 1 ] } { $i < $iterations } { incr i } {
        set s $i
        string_init $s
        string_set $s "message $i"
        adlb::insert $c $i $s
    }

    adlb::close $c
    set z [ adlb::container_size $c ]
    puts "container size: $z"
} else {
    adlb::server
}

turbine::finalize

puts OK
