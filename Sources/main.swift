import Vapor
import HTTP

let drop = Droplet()

drop.get("/") { _ in
  return "Hello Vapor"
}
drop.get("user", ":id"){ request in
  guard let userId = request.parameters["id"]?.int else {
    throw Abort.badRequest
  }
  return try JSON(node: [
        "number": userId,
        "text": "unicorns",
        "bool": false
    ])
}
drop.get("products"){ request in
    let products = try drop.client.get("http://apiror.herokuapp.com/products.json")
    return products
}
drop.run()