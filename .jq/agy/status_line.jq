# Render Antigravity status line

def _bold(exp):
    "\u001b[1m\(exp)\u001b[0m";

def _green(exp):
    "\u001b[92m\(exp)\u001b[0m";

def _yellow(exp):
    "\u001b[93m\(exp)\u001b[0m";

def _red(exp):
    "\u001b[91m\(exp)\u001b[0m";

def _percentage(exp):
    (exp // 0) | . * 10 | round | . / 10 |
    if . >= 90.0 then
        _red(. | tostring | . + "%")
    elif . >= 60.0 then
        _yellow(. | tostring | . + "%")
    else
        _green(. | tostring | . + "%")
    end;

def _capitalize(exp):
    exp | split(" ") | map((.[:1] | ascii_upcase) + .[1:]) | join (" ");

def _count(exp):
    if exp | type == "array" then
        (exp | length)
    elif exp | type == "number" then
        (exp | nearbyint)
    else
        0
    end;

def _remove_snake(exp):
    exp | split("_") | join(" ");

def status_line:
    {
        status: _capitalize(_remove_snake(.agent_state)),
        model: (.model.display_name // "N/A"),
        "Context Usage": _percentage(.context_window.used_percentage // 0),
        "Input Queue": _count(.pending_input_count),
        artifacts: _count(.artifact_count),
        "Background Tasks": _count(.task_count),
        # subagents: _count(.subagents),
    } | to_entries | map([_bold(_capitalize(.key)), .value] | join(": ")) | join(" | ");
