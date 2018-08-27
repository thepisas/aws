amzorarfd01 
===========
{
"Resources": {
  "myOracle": {    
    "Type": "AWS::RDS::DBInstance",
    "Properties": {
    "AllocatedStorage" : "143",
    "AutoMinorVersionUpgrade" : "True",
    "BackupRetentionPeriod" : "35",
    "CharacterSetName" : "AL32UTF8",
    "DBInstanceClass" : "db.m4.large",
    "DBInstanceIdentifier" : "amzorarfd01",
    "DBSubnetGroupName" : "default-vpc-6057bd06",
    "DBName" : "ORACL1",
    "DBParameterGroupName" : "oracl1-parameter",
    "Engine" : "oracle-se2",
    "EngineVersion" : "12.1.0.2.v5",
    "LicenseModel" : "license-included",
    "MasterUsername" : "oracle",
    "MasterUserPassword" : "****",
    "MultiAZ" : "False",
    "Port" : "1521",
    "StorageType" : "gp2",
    "StorageEncrypted" : "True",
    "VPCSecurityGroups" : ["sg-96c0b3eb"],
    "PreferredBackupWindow" : "04:00-06:00",
    "PreferredMaintenanceWindow" : "sun:07:00-sun:08:00",
    "PubliclyAccessible" : "False",
    "Tags" : [{"Key":"DB_Engine","Value":"Oracle"},{"Key":"Environment","Value":"Dev"},{"Key":"Apllication","Value":"RF"},{"Key":"workload-type","Value":"other"}]
}
}
}
}

"Resources": {
  "myOracle": {    
    "Type": "AWS::RDS::DBInstance",
    "Properties": {
    "AllocatedStorage" : "143",
    "AutoMinorVersionUpgrade" : "False",
    "BackupRetentionPeriod" : "35",
    "CharacterSetName" : "AL32UTF8",
    "DBInstanceClass" : "db.m4.large",
    "DBInstanceIdentifier" : "amzorarfq01",    
    "DBSubnetGroupName" : "qa-edh-tco-inf-db-az1",
    "DBName" : "ORACL1",
    "DBParameterGroupName" : "oracl1-parameter",
    "Engine" : "oracle-se2",
    "EngineVersion" : "12.1.0.2.v6",
    "LicenseModel" : "license-included",
    "MasterUsername" : "master",
    "MasterUserPassword" : "****",
    "MultiAZ" : "True",
    "Port" : "1521",
    "StorageType" : "gp2",
    "StorageEncrypted" : "True",
    "VPCSecurityGroups" : ["sg-88fbf6f4"],
    "PreferredBackupWindow" : "11:00-11:30",
    "PreferredMaintenanceWindow" : "sun:07:00-sun:08:00",
    "PubliclyAccessible" : "False",
    "Tags" : [{"Key":"DB_Engine","Value":"Oracle"},{"Key":"Environment","Value":"QA"},{"Key":"Apllication","Value":"RF"},{"Key":"workload-type","Value":"other"}]
}
}
}
