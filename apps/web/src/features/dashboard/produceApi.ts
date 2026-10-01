import { apiClient } from '../../core/api/apiClient';

export interface ProduceListingDto {
  id: string;
  quantityAvailable: number;
  unit: string;
  grade: string | null;
  location: string;
  status: string;
  commodity: { name: string };
  farmer: { user: { name: string } };
}

export async function fetchActiveProduceListings(): Promise<ProduceListingDto[]> {
  const { data } = await apiClient.get<ProduceListingDto[]>('/produce');
  return data;
}
