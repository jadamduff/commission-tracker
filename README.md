User

  name:string
  email:string
  password:string
  manager:boolean

  has_many :sales
  has_many :products, through: :sales

Product

  title:string
  price:float
  commission:float
  manager_id:integer

  has_many :sales
  has_many :users, through: :sales

Sale

  quantity:integer
  belongs_to :product
  belongs_to :user
