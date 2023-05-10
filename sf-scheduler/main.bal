import ballerina/sql;
import ballerinax/mssql;
import ballerinax/mssql.driver as _;
import ballerinax/salesforce;
import ballerina/io;

public function main() returns error? {
    io:println("Hello, World!");
    salesforce:Client salesforceEp = check new (config = {
        baseUrl: "",
        auth: {
            token: ""
        }
    });

    stream<record {}, error?> results = check salesforceEp->query("SELECT Id, Name FROM Account LIMIT 10");

    mssql:Client mssqlEp = check new ();

    sql:ExecutionResult[] batchExecuteResponse = check mssqlEp->batchExecute(getQueries(results));
}

function getQueries(stream<record {|anydata...;|}, error?> results) returns sql:ParameterizedQuery[] {
    return [];
}

