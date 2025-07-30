const { OpenAI } = require("openai");
const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

exports.handler = async (event) => {
  // Handle CORS preflight
  if (event.requestContext.http.method === "OPTIONS") {
    return {
      statusCode: 200,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "OPTIONS,POST"
      },
      body: "OK"
    };
  }

  try {
    const body = typeof event.body === "string" ? JSON.parse(event.body) : event.body;
    console.info("✅ Request body parsed:", JSON.stringify(body));

    const chatCompletion = await openai.chat.completions.create({
      model: "gpt-4o",
      messages: body.messages,
      temperature: 0.6
    });

    return {
      statusCode: 200,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "OPTIONS,POST"
      },
      body: JSON.stringify({ reply: chatCompletion.choices[0].message.content })
    };
  } catch (error) {
    console.error("Lambda Error:", error.message || error);
    return {
      statusCode: 500,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "OPTIONS,POST"
      },
      body: JSON.stringify({
        error: "Internal Server Error",
        detail: error.message
      })
    };
  }
};
