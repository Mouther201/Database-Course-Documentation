-- Task 1: INNER JOIN - List all alerts with the corresponding server name
SELECT a.alert_id, a.alert_type, a.severity, s.server_name
FROM Alerts a
INNER JOIN Servers s ON a.server_id = s.server_id;

-- Task 2: LEFT JOIN - List all servers and any alerts they might have received
SELECT s.server_id, s.server_name, a.alert_id, a.alert_type, a.severity
FROM Servers s
LEFT JOIN Alerts a ON s.server_id = a.server_id;

-- Task 3: RIGHT JOIN - Show all alerts and the server name that triggered them
SELECT a.alert_id, a.alert_type, a.severity, s.server_name
FROM Servers s
RIGHT JOIN Alerts a ON s.server_id = a.server_id;

-- Task 4: FULL OUTER JOIN - List all servers and alerts, including unmatched ones
SELECT s.server_name, a.alert_id, a.alert_type, a.severity
FROM Servers s
FULL OUTER JOIN Alerts a ON s.server_id = a.server_id;

-- Task 5: CROSS JOIN - Pair every AI model with every server
SELECT m.model_name, s.server_name
FROM AI_Models m
CROSS JOIN Servers s;

-- Task 6: INNER JOIN with Filter - List all critical alerts with server name
SELECT a.alert_id, a.alert_type, a.severity, s.server_name
FROM Alerts a
INNER JOIN Servers s ON a.server_id = s.server_id
WHERE a.severity = 'Critical';

-- Task 7: LEFT JOIN with NULL Filter - Find servers without any AI model deployed
SELECT s.server_id, s.server_name
FROM Servers s
LEFT JOIN ModelDeployments md ON s.server_id = md.server_id
WHERE md.deployment_id IS NULL;

-- Task 8: CROSS JOIN with WHERE - Simulate possible deployments for EU servers only
SELECT m.model_name, s.server_name
FROM AI_Models m
CROSS JOIN Servers s
WHERE s.region LIKE 'eu-%';
