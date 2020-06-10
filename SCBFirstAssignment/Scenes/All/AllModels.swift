struct All {
  struct FetchMobiles {
    struct Request {
    }

    struct Response {
      let content: Content<[Mobile]>
    }

    struct ViewModel {
      struct DisplayedMobile {
        let id: Int!
        let name: String!
        let description: String!
        let price: String!
        let rating: String!
        let thumbImageURL: String!
        let isFav: Bool!
      }

      let displayedMobiles: Content<[DisplayedMobile]>
    }
  }

  struct SortMobiles {
    struct Request {
      let sortingType: Constants.SortingType
    }

    struct Response {
    }
  }

  struct UpdateFavourite {
    struct Request {
      let id: Int
    }

    struct Response {
    }
  }
}
