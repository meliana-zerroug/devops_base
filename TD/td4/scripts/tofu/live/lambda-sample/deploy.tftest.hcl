# Exercise 11: Test with JSON response
run "deploy" {
  command = apply
}

run "validate_json_response" {
  command = apply

  module {
    source = "../../modules/test-endpoint"
  }

  variables {
    endpoint = run.deploy.api_endpoint
  }

  assert {
    condition     = data.http.test_endpoint.status_code == 200
    error_message = "Unexpected status code: ${data.http.test_endpoint.status_code}"
  }

  assert {
    condition     = can(jsondecode(data.http.test_endpoint.response_body))
    error_message = "Response body is not valid JSON: ${data.http.test_endpoint.response_body}"
  }

  assert {
    condition     = jsondecode(data.http.test_endpoint.response_body).message == "Hello, World!"
    error_message = "Unexpected message in JSON response: ${jsondecode(data.http.test_endpoint.response_body).message}"
  }
}

# Exercise 12: Negative test case for 404
run "validate_404_error" {
  command = apply

  module {
    source = "../../modules/test-endpoint"
  }

  variables {
    endpoint = "${run.deploy.api_endpoint}/nonexistent"
  }

  assert {
    condition     = data.http.test_endpoint.status_code == 404
    error_message = "Expected 404 for non-existent resource, got: ${data.http.test_endpoint.status_code}"
  }

  assert {
    condition     = can(jsondecode(data.http.test_endpoint.response_body))
    error_message = "404 response body is not valid JSON"
  }

  assert {
    condition     = jsondecode(data.http.test_endpoint.response_body).error == "Resource not found"
    error_message = "Unexpected error message in 404 response"
  }
}

