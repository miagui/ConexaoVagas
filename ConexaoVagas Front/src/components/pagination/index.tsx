// https://github.com/bradtraversy/simple_react_pagination/blob/master/src/components/Pagination.js

import React from 'react';
import './index.css'

const Pagination = (props: any) => {
    const pageNumbers = [];

    for (let i = 1; i <= Math.ceil(props.totalObjects / props.objectsPerPage); i++) {
        pageNumbers.push(i);
    }

    return (
        <nav className={props.className}>
            <p>Páginas</p>
            <ul className='pagination'>
                {pageNumbers.map(number => (
                    <li key={number} className='page-item'>
                        <span onClick={() => {
                            window.scrollTo(0,0);
                            props.paginate(number);
                        }} 
                            className='page-link cursor-pointer'>
                            {number}
                        </span>
                    </li>
                ))}
            </ul>
        </nav>
    );
};

export default Pagination;