struct Detail {
  struct MobileDetail {
    struct Request {
      let id: Int
    }

    struct Response {
      let detailedMobile: Mobile
    }

    struct ViewModel {
      let id: Int!
      let name: String!
      let description: String!
      let price: String!
      let rating: String!
    }
  }

  struct DetailImage {
    struct Request {
      let id: Int
    }

    struct Response {
      let content: Content<ImageResponse>
    }

    struct ViewModel {
      struct displayedImage {
        let imageURL: String
      }

      let displayedImages: Content<[displayedImage]>
    }
  }
}
