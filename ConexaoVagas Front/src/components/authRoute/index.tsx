import React from 'react'
import { Redirect, Route, RouteComponentProps } from 'react-router-dom';
import { Jwt, usuarioAutenticado } from '../../services/auth';

interface Props {
	Component: React.FC<RouteComponentProps>;
	path: string;
	exact?: boolean;
	requiredRole: number;
}
export const AuthRoute = ({ Component, path, exact = false, requiredRole }: Props): JSX.Element => {

	const roleValido = Jwt()?.Role == requiredRole;
	return (
		<Route
			exact={exact}
			path={path}
			component={(props: RouteComponentProps) =>
				usuarioAutenticado && roleValido ? (
					<Component {...props} />
				) : (
					<Redirect
						to={{
                            pathname: "/404"
                    }}/>
				)
			}
		/>
	);
};
