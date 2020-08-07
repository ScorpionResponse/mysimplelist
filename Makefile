SERVER_PID := "$(shell cat run/server.pid)"

.PHONY: none dbinit dbstart dbswitch dbstop dbstopother db run iex

none: ;

dbinit:
	initdb --no-locale --encoding=UTF-8
	createuser postgres --createdb

dbstart:
	sudo mkdir /run/postgresql; sudo chown root:users /run/postgresql; sudo chmod g+w /run/postgresql
	pg_ctl -l "${PGDATA}/server.log" start

dbstopother:
	killall postgres

dbstop:
	pg_ctl stop

dbswitch: | dbstopother dbstart

start:
	# PORT=4040 elixir --erl "-detached" -S mix phx.server
	mkdir -p run
	mix phx.server > run/dev.log 2>&1 &

stop:
	pkill -15 beam

sleep:
	sleep 2

restart: stop sleep start

db:
	psql -U postgres mysimplelist_dev

iex:
	iex -S mix

test:
	MIX_ENV=test mix test

tail:
	tail -f run/dev.log
