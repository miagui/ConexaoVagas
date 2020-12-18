import React from 'react';
import InputMask, { Props } from 'react-input-mask';
// import '../../components/input/style.css';

interface InputProps extends Props {
    label?: string;
    name: string;
    hideLabel?: boolean;
}

const Input: React.FC<InputProps> = ({ label, name, hideLabel, ...props }) => {
    return (
        <div className={props.className}>
            {!hideLabel && (<div><label className={"font-bold pt-3"} htmlFor={name}>{label}</label><br /></div>)}
            <div className="rounded-md border-2 border-gray-400 w-64
                            hover:border-gray-500 w-full">
                <InputMask value="" {...props} type={props.type} className="bg-white focus:bg-gray-100 border-0 
                                            focus:outline-none w-full py-2 px-2 
                                            appearance-none"
                    id={name}>
                </InputMask>
            </div>
        </div>
    );
}

export default Input;