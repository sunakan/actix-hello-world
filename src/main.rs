use actix_web::{get, post, web, App, HttpServer, Responder, HttpResponse};
use std::env;

#[get("/")]
async fn hello() -> impl Responder {
    HttpResponse::Ok().body("HelloWorld")
}

#[post("echo")]
async fn echo(req_body: String) -> impl Responder {
    HttpResponse::Ok().body(req_body)
}

async fn manual_hello() -> impl Responder {
    HttpResponse::Ok().body("Hey there!")
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let port = env::var("PORT")
        .unwrap_or_else(|_| "8080".to_string())
        .parse()
        .expect("PORT must be a number");
    HttpServer::new(|| {
        App::new()
            .service(hello)
            .service(echo)
            .route("/hey", web::get().to(manual_hello))
    }).bind(("0.0.0.0", port))?
        .run()
        .await
}
