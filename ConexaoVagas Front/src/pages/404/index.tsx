import React from 'react';
import Foto from '../../assets/imgs/erro.jpg';
import './index.css'

function Erro() {
    return (

        <div className="bg-white flex css ">
            <div className="flex flex-col m-auto p-5 items-center">
                <p className="texto">Sua página não foi encontrada :(</p>
                <img src={Foto} alt="" className="foto object-contain" />
            </div>
        </div>

    );
}

export default Erro;