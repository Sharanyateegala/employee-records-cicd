import csv
from pathlib import Path

# Location of the existing employee records file
csv_file = Path(__file__).resolve().parent.parent / "records.csv"

# Five new employees
new_employees = [
    ["206", "Ananya", "IT", "Austin"],
    ["207", "Vikram", "DevOps", "Dallas"],
    ["208", "Meena", "HR", "Houston"],
    ["209", "Rohit", "Finance", "Irving"],
    ["210", "Divya", "Operations", "Plano"]
]

# Read existing employee records
with open(csv_file, "r", newline="", encoding="utf-8-sig") as file:
    records = list(csv.reader(file))

# Check existing employee IDs
existing_ids = {row[0] for row in records[1:] if row}

# Add only new employees
added = 0

for employee in new_employees:
    if employee[0] not in existing_ids:
        records.append(employee)
        added += 1

# Save the updated CSV file
with open(csv_file, "w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    writer.writerows(records)

print(f"Successfully added {added} employees")
print(f"Total employees: {len(records) - 1}")

import subprocess

# Locate the GitHub repository folder
repo_folder = csv_file.parent

# Automatically stage the updated files
subprocess.run(
    ["git", "add", "records.csv", "scripts/add_records.py"],
    cwd=repo_folder,
    check=True
)

# Check whether there are changes to commit
changes = subprocess.run(
    ["git", "diff", "--cached", "--quiet"],
    cwd=repo_folder
)

if changes.returncode == 1:

    # Automatically commit the changes
    subprocess.run(
        ["git", "commit", "-m", "Update employee records using Python"],
        cwd=repo_folder,
        check=True
    )

    # Automatically push changes to GitHub
    subprocess.run(
        ["git", "push", "origin", "main"],
        cwd=repo_folder,
        check=True
    )

    print("Successfully pushed updated records to GitHub!")

elif changes.returncode == 0:
    print("No new changes to push.")

else:
    raise RuntimeError("Unable to check Git changes.")

