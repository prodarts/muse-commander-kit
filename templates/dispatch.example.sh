#!/bin/bash
# 派遣スクリプトの見本（2026年11月時点の CLI 仕様で確認）
# 使い方：仕事ごとに専用フォルダを作り、その中で実行する。
# 指示書 BRIEF.md を同じフォルダに置いておくこと。
# セッションIDは CLI が返した値から取り、dispatch.log に残す。
set -u
cd "$(dirname "$0")"

{
  echo "started: $(date -Iseconds)"
} >> dispatch.log

# --- Claude Code（新規セッション） ---
# JSON 出力の session_id を記録する
# claude -p "BRIEF.md を読んで実行し、報告を REPORT.md に書いてください" \
#   --model <model> --output-format json > claude-result.json
# python3 -c "import json;print(json.load(open('claude-result.json'))['session_id'])" >> dispatch.log
#
# 再開（条件を全部満たすときだけ、ID 明示）：
# claude -p --resume <session_id> "修正指示..."

# --- Codex（新規セッション） ---
# --json の thread.started イベントの thread_id を記録する
# codex exec --json "BRIEF.md を読んで実行し、報告を REPORT.md に書いてください" \
#   > codex-events.jsonl
# grep '"type":"thread.started"' codex-events.jsonl >> dispatch.log
#
# 再開：
# codex exec resume <thread_id> "修正指示..."

{
  echo "finished: $(date -Iseconds)"
} >> dispatch.log
