#!/bin/bash

mix local.hex --force
mix local.rebar --force

elixir /app/main.exs
