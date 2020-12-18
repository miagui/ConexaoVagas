declare module 'react-native-global-props';

// Permite arquivos .svg serem importados.
declare module "*.svg" {
    import React from 'react';
    import { SvgProps } from "react-native-svg";
    const content: React.FC<SvgProps>;
    export default content;
  }