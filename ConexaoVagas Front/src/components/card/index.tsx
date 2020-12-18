import React from 'react';

function Card(props: any) {
    return(
        <div {...props} className={"p-5 shadow shadow-md rounded-lg bg-white " + props.className} >
            {props.children}
        </div>
    )
}

export default Card