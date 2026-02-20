// Exercise 11
exports.handler = async (event) => {
  const path = event.path || '/';
  
  
  if (path === '/' || path === '/prod' || path === '/prod/') {
    return {
      statusCode: 200,
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        message: "Hello, World!",
        timestamp: new Date().toISOString(),
        path: path
      })
    };
  }
  
  // Exercise 12
  return {
    statusCode: 404,
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      error: "Resource not found",
      path: path
    })
  };
};

