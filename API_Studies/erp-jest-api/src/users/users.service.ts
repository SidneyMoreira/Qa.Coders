import { Injectable } from '@nestjs/common';
import { User } from './users';

@Injectable()
export class UsersService {
  private readonly users: User[];

  constructor() {
    this.users = [
      {
        id: 1,
        userName: 'naveen',
        password: '1234',
      },
      {
        id: 2,
        userName: 'ramanajee',
        password: '2345',
      },
      {
        id: 3,
        userName: 'gopi',
        password: '3456',
      },
      {
        id: 4,
        userName: 'rama krishna',
        password: '4567',
      },
    ];
  }

  async findOne(username: string): Promise<User | undefined> {
    return this.users.find((user) => user.userName === username);
  }
}
