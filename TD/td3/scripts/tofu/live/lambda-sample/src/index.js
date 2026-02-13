exports.handler = (event, context, callback) => {
  try {
    
    if (event.httpMethod === "POST" && event.path === "/data") {
      callback(null, { statusCode: 201, body: "Data created" });
      return;
    }

    
    callback(null, { statusCode: 200, body: "DevOps Base!" });

  } catch (error) {
    
    callback(null, { statusCode: 500, body: "Error" });
  }
};