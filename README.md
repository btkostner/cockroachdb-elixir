# Cockroach DB + Elixir

This repository demos a cockroach DB crash doing case insensitive lookup with Elixir and Ecto.

## Error

This is the full output from Elixir when running this:

```text
16:58:00.056 [info] Migrations already up

16:58:00.074 [debug] QUERY OK db=13.6ms queue=0.4ms idle=14.5ms
DELETE FROM users; []

16:58:00.093 [debug] QUERY OK db=2.3ms queue=0.6ms idle=44.8ms
INSERT INTO "users" ("email","id") VALUES ($1,$2) ["user-1@example.com", "30ec3eac-5b55-43b9-b062-ebe03479aacc"]

16:58:00.095 [debug] QUERY OK db=2.0ms queue=0.4ms idle=48.8ms
INSERT INTO "users" ("email","id") VALUES ($1,$2) ["user-2@example.com", "bce9da9a-41f0-41c7-a13d-ae94db708289"]

16:58:00.098 [debug] QUERY OK db=2.0ms queue=0.3ms idle=51.4ms
INSERT INTO "users" ("email","id") VALUES ($1,$2) ["user-3@example.com", "77d29951-b4f1-4c33-95f3-41f0364a342f"]

16:58:00.100 [debug] QUERY OK db=1.7ms queue=0.3ms idle=54.0ms
INSERT INTO "users" ("email","id") VALUES ($1,$2) ["user-4@example.com", "62289072-b552-4e28-b89d-c3bd2316c600"]

16:58:00.103 [debug] QUERY OK db=1.7ms queue=0.3ms idle=56.3ms
INSERT INTO "users" ("email","id") VALUES ($1,$2) ["user-5@example.com", "4b217164-9a34-4152-927d-34fdcc0dffba"]

16:58:00.105 [debug] QUERY OK db=1.8ms queue=0.3ms idle=58.6ms
INSERT INTO "users" ("email","id") VALUES ($1,$2) ["user-6@example.com", "ef4af7ec-c789-4bdc-9eb1-8303ce577775"]

16:58:00.107 [debug] QUERY OK db=1.6ms queue=0.3ms idle=60.8ms
INSERT INTO "users" ("email","id") VALUES ($1,$2) ["user-7@example.com", "2cfda089-3ac6-4aa6-b408-ccfe9ec4095e"]

16:58:00.109 [debug] QUERY OK db=1.8ms queue=0.3ms idle=61.2ms
INSERT INTO "users" ("email","id") VALUES ($1,$2) ["user-8@example.com", "318206bb-8d57-44d7-a804-8895b13ede34"]

16:58:00.111 [debug] QUERY OK db=1.7ms queue=0.2ms idle=57.1ms
INSERT INTO "users" ("email","id") VALUES ($1,$2) ["user-9@example.com", "c3f6e952-3786-42d6-9fce-406eab8646dc"]

16:58:00.114 [debug] QUERY OK db=2.3ms queue=0.2ms idle=38.7ms
INSERT INTO "users" ("email","id") VALUES ($1,$2) ["user-10@example.com", "dbb321a2-6d60-4b58-87d9-fdd223c41072"]

16:58:00.118 [debug] QUERY OK source="users" db=0.4ms queue=0.4ms idle=24.9ms
SELECT u0."id", u0."email" FROM "users" AS u0 WHERE (u0."email" = $1) ["USER-1@example.com"]

16:58:00.197 [debug] QUERY ERROR source="users" db=79.1ms idle=22.5ms
SELECT u0."id", u0."email" FROM "users" AS u0 WHERE (u0."email" = $1) ["USER-2@example.com"]
** (Postgrex.Error) ERROR XX000 (internal_error) internal error: failed to parse locale "": language: tag is not well-formed

    hint: You have encountered an unexpected error.

Please check the public issue tracker to check whether this problem is
already tracked. If you cannot find it there, please report the error
with details by creating a new issue.

If you would rather not post publicly, please contact us directly
using the support form.

We appreciate your feedback.


stack trace:
github.com/cockroachdb/cockroach/pkg/sql/sem/tree/datum.go:1334: getCacheEntry()
github.com/cockroachdb/cockroach/pkg/sql/sem/tree/datum.go:1349: NewDCollatedString()
github.com/cockroachdb/cockroach/pkg/sql/sem/tree/cast.go:2108: performCastWithoutPrecisionTruncation()
github.com/cockroachdb/cockroach/pkg/sql/sem/tree/cast.go:1474: PerformCast()
github.com/cockroachdb/cockroach/pkg/sql/sem/tree/eval.go:4187: Eval()
github.com/cockroachdb/cockroach/pkg/sql/sem/tree/eval.go:4878: Eval()
github.com/cockroachdb/cockroach/pkg/sql/opt/exec/execbuilder/relational.go:769: buildPlaceholderScan()
github.com/cockroachdb/cockroach/pkg/sql/opt/exec/execbuilder/relational.go:220: buildRelational()
github.com/cockroachdb/cockroach/pkg/sql/opt/exec/execbuilder/builder.go:234: build()
github.com/cockroachdb/cockroach/pkg/sql/opt/exec/execbuilder/builder.go:194: Build()
github.com/cockroachdb/cockroach/pkg/sql/plan_opt.go:616: runExecBuilder()
github.com/cockroachdb/cockroach/pkg/sql/plan_opt.go:294: makeOptimizerPlan()
github.com/cockroachdb/cockroach/pkg/sql/conn_executor_exec.go:1433: makeExecPlan()
github.com/cockroachdb/cockroach/pkg/sql/conn_executor_exec.go:1103: dispatchToExecutionEngine()
github.com/cockroachdb/cockroach/pkg/sql/conn_executor_exec.go:747: execStmtInOpenState()
github.com/cockroachdb/cockroach/pkg/sql/conn_executor_exec.go:179: execStmt()
github.com/cockroachdb/cockroach/pkg/sql/conn_executor_exec.go:267: execPortal()
github.com/cockroachdb/cockroach/pkg/sql/conn_executor.go:1969: func2()
github.com/cockroachdb/cockroach/pkg/sql/conn_executor.go:1971: execCmd()
github.com/cockroachdb/cockroach/pkg/sql/conn_executor.go:1817: run()
github.com/cockroachdb/cockroach/pkg/sql/conn_executor.go:763: ServeConn()
github.com/cockroachdb/cockroach/pkg/sql/pgwire/conn.go:728: func1()
GOROOT/src/runtime/asm_amd64.s:1581: goexit()

    (ecto_sql 3.9.1) lib/ecto/adapters/sql.ex:913: Ecto.Adapters.SQL.raise_sql_call_error/1
    (ecto_sql 3.9.1) lib/ecto/adapters/sql.ex:828: Ecto.Adapters.SQL.execute/6
    (ecto 3.9.2) lib/ecto/repo/queryable.ex:229: Ecto.Repo.Queryable.execute/4
    (ecto 3.9.2) lib/ecto/repo/queryable.ex:19: Ecto.Repo.Queryable.all/3
    (ecto 3.9.2) lib/ecto/repo/queryable.ex:159: Ecto.Repo.Queryable.one!/3
    main.exs:44: anonymous fn/2 in Main.run/0
    (elixir 1.14.1) lib/enum.ex:4299: Enum.reduce_range/5
    main.exs:43: Main.run/0
```

## Setup

This uses Docker Compose to run an instance of cockroach db and an elixir container to test. You should be able to run `docker-compose up` and have everything executed.
