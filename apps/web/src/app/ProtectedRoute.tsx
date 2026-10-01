import type { ReactNode } from 'react';
import { Navigate } from 'react-router-dom';

import { useAuth } from '../core/auth/AuthContext';
import { AppLayout } from '../core/components/AppLayout';

export function ProtectedRoute({ children }: { children: ReactNode }) {
  const { isAuthenticated } = useAuth();

  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  return <AppLayout>{children}</AppLayout>;
}
