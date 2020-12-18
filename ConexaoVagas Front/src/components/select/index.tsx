import React, { SelectHTMLAttributes } from 'react';

interface SelectProps extends SelectHTMLAttributes<HTMLSelectElement> {
    label: string;
    name: string;
}

const Select: React.FC<SelectProps> = ({ label, name, ...rest }) => {
    return (
        <div className={rest.className}>
            <label className="font-bold" htmlFor={name}>{label}</label><br />
            <div className="rounded-md border-2 border-gray-400 w-64
                            hover:border-gray-500 w-full">
                <select {...rest} className="bg-gray-100 focus:bg-white border-0 
                                            focus:outline-none w-full py-2 px-2"
                    id={name}>
                    {rest.children}
                </select>
            </div>
        </div>
    );
}

export default Select;