#!/bin/sh
echo '{"version":1}[[],'
exec conky -c ~/.conky/conkyi3 2>/dev/null
