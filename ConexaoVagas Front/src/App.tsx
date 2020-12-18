import React from 'react';
import Routers from './routers';
import AlertTemplate from "react-alert-template-basic";
import { positions, Provider } from "react-alert";
import './assets/styles/overrides.css';
import './assets/styles/global.css';
import './assets/styles/tailwind.css';

const options = {
  timeout: 5000,
  position: positions.BOTTOM_CENTER,
};

function App() {
  return (
    <Provider template={AlertTemplate} {...options}>
      <div id="root" className="App">
        <Routers></Routers>
      </div>
    </Provider>
  );
}

export default App;
