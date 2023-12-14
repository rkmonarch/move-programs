module my_addrx::Sample
{
    use std::debug;

    fun sample_function()
    {
        debug::print(&12345);
    }

    #[test]
    fun testing()
    {
        sample_function();
    }
}

module my_addrx::Application {
	use std::vector;
    use std::debug;
	use std::string::{String,utf8};

	struct Users has key,drop {
		list_of_users: vector<User>    //storing the list of the users
	}

	struct User has store,drop,copy {
		name:String,                   //information required for a typical user
		age:u8
	}
     struct Products has key, drop{
        list_of_products: vector<Product>,
    }

    struct Product has store,copy,drop {
        name: String,
        image: String,
        price: u64,
        location: String,
    }

        //creating a user by adding the user to the existing list and returning the user
	public fun create_user(newUser: User,users: &mut Users): User{
		vector::push_back(&mut users.list_of_users,newUser);
		return newUser
	}
	
    public fun create_product(newProduct: Product,products: &mut Products): Product {
       vector::push_back(&mut products.list_of_products, newProduct);
       return newProduct
    }

	#[test]
	fun test_create_friend(){
		let user1 = User {
			name:utf8(b"Tony"),
			age:50,
		};
		
        let users = Users{
			list_of_users: vector::empty<User>()
		};

		let createdUser = create_user(user1,&mut users);
        debug::print(&users);
        assert!(createdUser.name == utf8(b"Tony"),0);
	}

      #[test]
	fun test_create_product(){
		let product1 = Product {
			name:utf8(b"Tony"),
            image:utf8(b"Tony"),
			price:50,
            location:utf8(b"Vadodara")
		};
		
        let products = Products{
			list_of_products: vector::empty<Product>()
		};

		let createdProduct = create_product(product1,&mut products);
        debug::print(&products);
        assert!(createdProduct.name == utf8(b"Tony"),0);
	}
}