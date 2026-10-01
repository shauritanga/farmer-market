import axios from 'axios';

import { tokenStorage } from '../auth/tokenStorage';

/**
 * Shared HTTP client. Kept in `core/api` because every feature's data
 * layer depends on it — base URL and auth header injection are genuine
 * cross-feature concerns (same reasoning as the mobile app's ApiClient).
 */
export const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL ?? 'http://localhost:3000',
});

apiClient.interceptors.request.use((config) => {
  const token = tokenStorage.read();
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      tokenStorage.clear();
      window.location.assign('/login');
    }
    return Promise.reject(error);
  },
);
