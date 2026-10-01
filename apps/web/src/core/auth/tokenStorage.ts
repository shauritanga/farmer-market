const ACCESS_TOKEN_KEY = 'fama_admin_access_token';

/**
 * Plain localStorage for the admin dashboard's own session token. This is
 * a separate, admin-only credential — never the mobile app's token, and
 * never a role read off the client (see AGENTS.md §9: backend authorization
 * is authoritative, not client-side role checks).
 */
export const tokenStorage = {
  read(): string | null {
    return localStorage.getItem(ACCESS_TOKEN_KEY);
  },
  save(token: string): void {
    localStorage.setItem(ACCESS_TOKEN_KEY, token);
  },
  clear(): void {
    localStorage.removeItem(ACCESS_TOKEN_KEY);
  },
};
