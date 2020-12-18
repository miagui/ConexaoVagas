import React from 'react'
import Hamburguer from '../../components/hamburguer'
import Loader from '../../components/loader'
import Sidebar from '../../components/sidebar/Index'

function LoadingPage() {
    return (
        <div className="body w-full">
            <Hamburguer className="md:hidden flex fixed" />
            <Sidebar className="md:flex hidden" />
            <main className="w-full flex justify-center items-center">
                <Loader/>
            </main>
        </div>
    )
}

export default LoadingPage
