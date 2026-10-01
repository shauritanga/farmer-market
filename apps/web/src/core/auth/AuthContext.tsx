import {
  createContext,
  useCallback,
  useContext,
  useMemo,
  useState,
  type ReactNode,
} from 'react';

import { apiClient } from '../api/apiClient';
import { tokenStorage } from './tokenStorage';

export interface AdminUser {
  id: string;
  name: string;
  phoneNumber: string;
  role: string;
}

interface LoginResponse {
  user: AdminUser;
  accessToken: string;
  refreshToken: string;
}

interface AuthContextValue {
  user: AdminUser | null;
  isAuthenticated: boolean;
  login: (phoneNumber: string, password: string) => Promise<void>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextValue | undefined>(undefined);

// NOTE: session is not restored on page reload — there is no `/auth/me`
// endpoint yet to re-hydrate `user` from a stored token. Add one before
// this dashboard is used for real; until then a refresh requires login.
export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<AdminUser | null>(null);

  const login = useCallback(async (phoneNumber: string, password: string) => {
    const { data } = await apiClient.post<LoginResponse>('/auth/login', {
      phoneNumber,
      password,
    });
    tokenStorage.save(data.accessToken);
    setUser(data.user);
  }, []);

  const logout = useCallback(() => {
    tokenStorage.clear();
    setUser(null);
  }, []);

  const value = useMemo<AuthContextValue>(
    () => ({ user, isAuthenticated: user !== null, login, logout }),
    [user, login, logout],
  );

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth(): AuthContextValue {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
