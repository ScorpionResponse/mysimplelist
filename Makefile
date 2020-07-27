
.PHONY: none dbinit dbstart dbswitch dbstop dbstopother

none: ;

dbinit:
	initdb --no-locale --encoding=UTF-8
	createuser postgres --createdb

dbstart:
	pg_ctl -l "${PGDATA}/server.log" start

dbstopother:
	killall postgres

dbstop:
	pg_ctl stop

dbswitch: | dbstopother dbstart

run:
	# PORT=4040 elixir --erl "-detached" -S mix phx.server
	mix phx.server > dev.log 2>&1 &
