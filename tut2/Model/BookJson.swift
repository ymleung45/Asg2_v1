import Foundation

class BookJson{
    
    var isbnString = ""
    
    struct IsbnData: Codable {
        let bookdata: Bookdata
        
        enum CodingKeys: String, CodingKey{
            case bookdata = "ISBN"
        }
    }
    
    struct Bookdata: Codable {
        let title: String
        let url: String
        let publishDate: String
        let numberOfPages: Int
        let publishers: [Publishers]
        let authors: [Authors]
        let cover: Cover
        
        
        enum CodingKeys2: String, CodingKey{
            case publishDate = "publish_date"
            case numberOfPages = "number_of_pages"
        }
    }
    
    struct Publishers: Codable {
        let name: String
    }
    
    struct Authors: Codable {
        let name: String
    }
    struct Cover: Codable {
        let medium: String
    }
    
    
    
    func getdata(id:String){
        var datas = ""
        
        let url = URL(string: "https://openlibrary.org/api/books?bibkeys=ISBN:" + id + "&jscmd=data&format=json")!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            datas = String(data: data!, encoding: .utf8)!
            datas =  "{\"ISBN\"" + String(datas.dropFirst(21))
            
            print(datas)
            
            
            guard let data = datas.data(using: String.Encoding.utf8)
                else { fatalError("error") }
            
            do {
                let decoder = JSONDecoder()      //decoding
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let book = try decoder.decode(IsbnData.self, from: data)
                //                print(book)
                
                let bookInstance = BookModel(
                    title: book.bookdata.title,
                    url: book.bookdata.url,
                    publishDate: book.bookdata.publishDate,
                    numberOfPages: book.bookdata.numberOfPages,
                    publishers: book.bookdata.publishers[0].name,
                    authors: book.bookdata.authors[0].name,
                    cover: book.bookdata.cover.medium,
                    isbn: "12345678"
                )
                
                print(bookInstance.title)
                
                DispatchQueue.main.async {
                    bookInstance.storebook()
                }
                
            }
            catch {
                print(error)
            }
        })
        task.resume()
    }
    
    
}
