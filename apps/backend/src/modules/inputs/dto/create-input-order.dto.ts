import { IsNumber, IsPositive, IsUUID } from 'class-validator';

export class CreateInputOrderDto {
  @IsUUID()
  inputId!: string;

  @IsNumber()
  @IsPositive()
  quantity!: number;
}
