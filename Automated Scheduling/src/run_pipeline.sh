set -e

PYTHON="/Library/Frameworks/Python.framework/Versions/3.12/bin/python3"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[$(date)] Mulai pipeline..."

cd "$SCRIPT_DIR/../../Data Scraping/src"
"$PYTHON" -c "from products import main; main()"
"$PYTHON" -c "from variants import main; main()"
"$PYTHON" -c "from categories import main; main()"

cd "$SCRIPT_DIR/../../Data Storing/src"
"$PYTHON" load_to_postgres.py

cd "$SCRIPT_DIR"
"$PYTHON" log_run.py

echo "[$(date)] Pipeline selesai."