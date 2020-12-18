import React, { InputHTMLAttributes, TextareaHTMLAttributes } from 'react'

interface InputProps extends TextareaHTMLAttributes<HTMLTextAreaElement> {
    label?: string;
    name: string;
    hideLabel?: boolean;
}

const TextArea: React.FC<InputProps> = ({ label, name, hideLabel, ...props }) => {
    return (
        <div className={props.className}>
            {!hideLabel && (<div><label className={"font-bold pt-3"} htmlFor={name}>{label}</label><br /></div>)}
            <div className="rounded-md border-2 border-gray-400 w-64 hover:border-gray-500 w-full">
                <textarea {...props} className="bg-white focus:bg-gray-100 border-0 
                                                        focus:outline-none w-full py-2 px-2 
                                                        appearance-none"
                    id={name}>
                </textarea>
            </div>
        </div>
    )
}

export default TextArea;