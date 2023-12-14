module my_addrx::RigelPool {
    use std::vector;
    use std::debug;
	use std::string::{String,utf8};

    struct Pool has store,copy,drop{
        creator: String,
        name: String,
        amount: u64,
        supportedTokens: vector<String>,
        supportedTokensAmount: vector<u64>,
    }

    struct Pools has store,copy,drop{
        list_of_pools: vector<Pool>,
    }

    struct PoolManagers has store,copy,drop{
        pool: Pool,
        managers: vector<address>,
    }

    public fun createPool(newPool:Pool, pools: &mut Pools): Pool{
        vector::push_back(&mut pools.list_of_pools,newPool);
		return newPool
    }

     #[test]
	fun test_create_pool(){
		let pool1 = Pool {
			creator: utf8(b"Tony"),
            name: utf8(b"Tony"),
            amount: 100,
            supportedTokens: vector::empty<String>(),
            supportedTokensAmount: vector::empty<u64>(),
        };
        
        let pools = Pools{
            list_of_pools: vector::empty<Pool>()
        };
		

		let createdPool = createPool(pool1,&mut pools);
        debug::print(&pools);
        assert!(createdPool.name == utf8(b"Tony"),0);
	}
}