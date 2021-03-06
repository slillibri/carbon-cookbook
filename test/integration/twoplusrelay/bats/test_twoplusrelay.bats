#!/usr/bin/env bats
@test "/opt/graphite/storage/carbon-cache-a.lock should exist" {
[ -f "/opt/graphite/storage/carbon-cache-a.lock" ]
}
@test "/opt/graphite/storage/carbon-cache-b.lock should exist" {
[ -f "/opt/graphite/storage/carbon-cache-b.lock" ]
}
@test "/opt/graphite/storage/carbon-relay-a.lock should exist" {
[ -f "/opt/graphite/storage/carbon-relay-a.lock" ]
}
@test "carbon-cache-a is set on cpu 1" {
[ $(taskset -pc `cat /opt/graphite/storage/carbon-cache-a.pid` | cut -d ':' -f 2) == 1 ]
}
@test "carbon-cache-b is set on cpu 2" {
[ $(taskset -pc `cat /opt/graphite/storage/carbon-cache-b.pid` | cut -d ':' -f 2) == 2 ]
}
@test "carbon-relay-a is set on cpu 0" {
[ $(taskset -pc `cat /opt/graphite/storage/carbon-relay-a.pid` | cut -d ':' -f 2) == 0 ]
}
@test "carbon-relay-a can accept traffic" {
echo "test.metric 1 `date +%s`"| nc 127.0.0.1 2003;
}
