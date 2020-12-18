import React, { useEffect, useState } from 'react';
import Modal from 'react-modal';
import './styles.css'

interface CustomDialogue extends Modal.Props {
    title: string;
}

const Dialog: React.FC<CustomDialogue> = ({ title, ...props }) => {

    const [open, setOpen] = useState(props.isOpen);

    useEffect(() => {
        setOpen(props.isOpen)
    }, [props]);


    const customStyles: ReactModal.Styles = {
        content: {
            top: '50%',
            left: '50%',
            right: 'auto',
            bottom: 'auto',
            marginRight: '-50%',
            transform: 'translate(-50%, -50%)',
            maxHeight: 'calc(100vh - 80px)',
            overflowY: 'auto',
            position: 'absolute'
        }
    };

    function closeModal() {
        setOpen(false)
    }

    Modal.setAppElement('#root');

    return (
        <Modal {...props}
            onRequestClose={props.onRequestClose} isOpen={open}
            style={customStyles} overlayClassName="dialog-overlay"
            shouldCloseOnOverlayClick={true}>
            <p className="pb-4 text-center">{title}</p>
            <hr />
            <div className="absolute h-6 w-6 rounded-full bg-transparent cursor-pointer
                            ri-close-line text-black hover:text-red-600 text-3xl
                            text-center right-0 top-0 flex items-center justify-center
                            transform -translate-x-2 translate-y-2 overflow-visible"
                onClick={closeModal}>
            </div>
            <div className="pt-2">
                {props.children}
            </div>
        </Modal>
    )

}

export default Dialog
