import json
import pandas as pd

with open('reports/trivy.json') as f:
    data = json.load(f)

rows = []

for result in data.get("Results", []):
    for vuln in result.get("Vulnerabilities", []):
        rows.append({
            "Package": vuln.get("PkgName"),
            "Severity": vuln.get("Severity"),
            "Vulnerability": vuln.get("VulnerabilityID"),
            "Installed": vuln.get("InstalledVersion"),
            "Fixed": vuln.get("FixedVersion")
        })

df = pd.DataFrame(rows)

writer = pd.ExcelWriter(
    'reports/security-report.xlsx',
    engine='xlsxwriter'
)

df.to_excel(writer, sheet_name='Trivy Report', index=False)

writer.close()

print("Excel report generated")