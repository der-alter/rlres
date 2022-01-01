module Hit = {
  type t = {
    title: option<string>,
    url: option<string>,
    author: string,
    objectId: string,
    commentText: option<string>,
    numComments: option<int>,
    points: option<int>,
    timestamp: int,
  }

  let fromJson = json => {
    open Json.Decode
    {
      title: json |> optional(field("title", string)),
      url: json |> optional(field("url", string)),
      author: json |> field("author", string),
      objectId: json |> field("objectID", string),
      commentText: json |> optional(field("comment_text", string)),
      numComments: json |> optional(field("num_comments", int)),
      points: json |> optional(field("points", int)),
      timestamp: json |> field("created_at_i", int),
    }
  }

  let parseHits = response =>
    response
    ->Option.flatMap(_, Js.Json.decodeObject)
    ->Option.flatMap(_, Js.Dict.get(_, "hits"))
    ->Option.map(_, Json.Decode.array(fromJson))
    ->Option.getExn(_)
}
