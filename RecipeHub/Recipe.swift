import Foundation

struct Recipe: Codable, Identifiable {
    let id: UUID
    let name: String
    let description: String
    let cookingTimeMinutes: Int
    let ingredients: [String]
    let steps: [String]

    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        cookingTimeMinutes: Int,
        ingredients: [String],
        steps: [String]
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.cookingTimeMinutes = cookingTimeMinutes
        self.ingredients = ingredients
        self.steps = steps
    }
}

extension Recipe {
    static let sampleData = [
        Recipe(
            name: "オムライス",
            description: "ふんわり卵で包む定番の洋食です。",
            cookingTimeMinutes: 20,
            ingredients: [
                "ごはん",
                "卵",
                "鶏肉",
                "玉ねぎ",
                "ケチャップ"
            ],
            steps: [
                "鶏肉と玉ねぎを炒める",
                "ごはんとケチャップを加えて炒める",
                "卵を焼いてごはんを包む"
            ]
        ),
        Recipe(
            name: "ハンバーグ",
            description: "肉汁を閉じ込めて焼く、ごはんに合う主菜です。",
            cookingTimeMinutes: 35,
            ingredients: [
                "合いびき肉",
                "玉ねぎ",
                "パン粉",
                "卵",
                "塩こしょう"
            ],
            steps: [
                "玉ねぎをみじん切りにして炒める",
                "材料を混ぜて形を整える",
                "フライパンで両面を焼く"
            ]
        ),
        Recipe(
            name: "唐揚げ",
            description: "下味をしっかりつけて揚げる人気のおかずです。",
            cookingTimeMinutes: 30,
            ingredients: [
                "鶏もも肉",
                "しょうゆ",
                "しょうが",
                "にんにく",
                "片栗粉"
            ],
            steps: [
                "鶏肉に下味をつける",
                "片栗粉をまぶす",
                "油でカリッと揚げる"
            ]
        )
    ]
}
