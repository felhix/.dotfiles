# Python CLI UI Spec

Reference for consistent Rich-based terminal UIs across scripts.

---

## Dependencies

```bash
pip install rich
```

```python
from rich.console import Console
from rich.table import Table
from rich.prompt import Confirm, Prompt
from rich.panel import Panel

console = Console()
```

---

## Script structure

```
1. Entry panel       — title + one-line description
2. Status line(s)    — querying, counting, scanning
3. Per-item loop     — rule divider + info table + prompts
4. Summary panel     — counts of what happened
```

---

## Panels

```python
# Entry — cyan border
console.print(Panel(
    "🛠️ [bold cyan]Script Title[/bold cyan]\n"
    "[dim]One-line description of what it does[/dim]",
    border_style="cyan",
))

# Summary — green border
console.print(Panel(
    f"✅ [green]Done:[/green]    {done} items\n"
    f"⏭️  [yellow]Skipped:[/yellow]  {skipped} items\n"
    f"❌ [red]Errors:[/red]   {errors} items",
    title="🎉 All done!",
    border_style="green",
))
```

---

## Progress divider

```python
console.rule(f"[dim] {i} / {total} [/dim]")
```

---

## Tables

Prefer `Table` over `console.print` for any multi-line structured output — Rich aligns columns for free.

### Label/value (info block)

Two-column layout. Labels fixed-width, values wrap freely.

```python
dash = "[dim]—[/dim]"

tbl = Table(show_header=False, box=None, padding=(0, 1))
tbl.add_column(style="bold dim", width=12, no_wrap=True)  # labels
tbl.add_column(no_wrap=False)                              # values

tbl.add_row("📋 Name",   f"[bold]{name or dash}[/bold]")
tbl.add_row("🏷️  Type",   f"[cyan]{kind}[/cyan]" if kind else dash)
tbl.add_row("📁 Path",   f"[dim]{path}[/dim]")
tbl.add_row("📅 Date",   date or dash)

console.print(tbl)
```

Rules:
- Always show `—` for empty values, never leave blank
- `width=12` fits all standard emoji labels without clipping
- File paths: always `[dim]`

### Numbered list (candidate picker)

Index column with blue number in plain brackets, then data columns: primary bold, secondary cyan, tertiary dim.

```python
tbl = Table(show_header=False, box=None, padding=(0, 1))
tbl.add_column(width=4, no_wrap=True)   # [1]
tbl.add_column(style="bold")            # primary
tbl.add_column(style="cyan")            # secondary
tbl.add_column(style="dim")             # tertiary…

for i, item in enumerate(items, 1):
    tbl.add_row(f"[[blue]{i}[/blue]]", item.title, item.artist, item.extra)

console.print(tbl)
```

---

## Prompts

```python
# Yes/no
do_it = Confirm.ask("✂️  Do the thing?", default=True)

# Free input with suggestion
raw = Prompt.ask("📋 Name [dim](comma-separated)[/dim]", default="Foo, Bar")

# Free input, no default (forces manual entry)
raw = Prompt.ask("📋 Name", default=None)

# Constrained choices
choice = Prompt.ask("  Source", choices=["1", "2", "3"])
```

---

## Colour conventions

| Colour    | Use |
|-----------|-----|
| `cyan`    | Primary data (key values, identifiers) |
| `green`   | Success, suggestions, confirmed writes |
| `yellow`  | Warnings, things needing attention |
| `magenta` | Secondary detections |
| `red`     | Errors |
| `blue`    | Neutral counts |
| `dim`     | Secondary info, file paths, placeholders (`—`) |
| `bold`    | Important values, names |

---

## Emoji conventions

| Emoji | Meaning |
|-------|---------|
| 📋 | Name / label |
| 🏷️  | Type / category |
| 📁 | File path |
| 📅 | Date |
| 🔎 | Pattern detected in a field |
| 💡 | Suggestion |
| 🔍 | Querying / searching |
| ✅ | Success |
| ❌ | Error |
| ⚠️  | Warning |
| ⏭️  | Skipped |
| ✨ | Already OK / nothing to do |
| 🎉 | Done |

Emojis act as visual type markers — at a glance they tell you what kind of thing you're looking at. The table above covers universal cases; add domain-specific ones freely. Trust the LLM to pick the right emoji for context — no need to enumerate every possible one.

---

## Status lines

```python
console.print("[yellow]🔍 Querying…[/yellow]")
console.print(f"[green]✅ {n} items found[/green]")
console.print(f"  ✨ [blue]{already_ok}[/blue] already OK — skipped")
console.print(f"  🟢 [green]{clean}[/green] nothing to do — skipped")
console.print(f"  🟡 [yellow]{to_review}[/yellow] need your attention")
```

---

## Command prompt (beets-style)

For interactive resolution loops where the user picks from a numbered list or issues a command. Brackets are plain, letter is `bold yellow`, rest of the word is normal text.

```python
commands = (
    "  [dim][[/dim][bold yellow]S[/bold yellow][dim]][/dim]kip,"
    "  [dim][[/dim][bold yellow]M[/bold yellow][dim]][/dim]ark missing,"
    "  [dim][[/dim][bold yellow]E[/bold yellow][dim]][/dim]nter search"
)

# With numbered options — default to first pick
Prompt.ask(f"  Pick [bold cyan]number[/bold cyan],{commands}", default="1")

# Without numbered options — no default
Prompt.ask(commands.lstrip())
```

---

## Error handling boilerplate

```python
try:
    from rich.console import Console
    # ...
except ImportError:
    print("Missing dependency: pip install rich")
    sys.exit(1)
```

## Fatal error helper

```python
def fatal(msg: str) -> None:
    console.print(f"\n  [red]❌ {msg}[/red]\n")
    sys.exit(1)
```
