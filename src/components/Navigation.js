import { ethers } from 'ethers';

const Navigation = ( {account, setAccount} ) => {

    const clickHandler = async ()=>{
        const accounts = await window.ethereum.request({ method:'eth_requestAccounts'});
        const account = ethers.utils.getAddress(accounts[0]);
        setAccount(account);
    }

    return (
        <nav>
           <div className='nav__brand'>
             <h1>Dappazon</h1>
           </div>
             <input 
                type= "text"
                className='nav__search'
             />
            {account? <button 
             type='button'
             className='nav__connect'
             >
                 {account.slice(0,4)+"..."+account.slice(32,42)}
             </button>:
             <button 
             type='button'
             className='nav__connect'
             onClick={clickHandler}
             >Connect</button>

            }




            
             <ul className='nav__links'>
                <li><a href="#Clothing & Jewelry">Clothing & Jewelry</a></li>
                <li><a href="#Electronics & Gadgets">Electronics & Gadgets</a></li>
                <li><a href='#Toys & Gaming'>Toys and Gaming</a></li>
             </ul>
        </nav>
    );
}

export default Navigation;