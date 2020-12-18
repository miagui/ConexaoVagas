import React from 'react';
import '../../components/loader/style.css';

function Loader(props: any) {
    return (
        <div className={"loader w-12 h-12 " + props.className}></div>
    )
}

export default Loader;