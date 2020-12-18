import React, { ButtonHTMLAttributes } from 'react';
import './style.css';

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
    ghost?: Boolean;
    color?: string;
}

const Button: React.FC<ButtonProps> = ({ ghost, ...props }) => {

    function renderNormal() {
        return (
            <button {...props} 
                type="button"
                className={"button-normal focus:outline-none " + props.className}>
                {props.children}
            </button>
        )
    }

    function renderGhost() {
        return (
            <button {...props} type="button"
                className={"button-ghost focus:outline-none " + props.className}>
                {props.children}
            </button>
        )
    }

    return (
        <div>
            {ghost ? renderGhost() : renderNormal()}
        </div>
    );
}

export default Button;
