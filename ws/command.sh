# Gymnasium 可选环境安装合集

# 经典控制环境（CartPole、MountainCar 等）
pip install "gymnasium[classic_control]"

# Box2D 环境（LunarLander、BipedalWalker 等）
pip install "gymnasium[box2d]"

# Atari 环境
pip install "gymnasium[atari]"

# MuJoCo 环境（Hopper、Walker2D 等）
pip install "gymnasium[mujoco]"

# Robotics 机器人环境（Fetch、Hand）
pip install "gymnasium[robotics]"

# Toy-text 文本环境（FrozenLake 等）
pip install "gymnasium[toy_text]"

# 安装所有环境（非常大）
pip install swig
pip install "gymnasium[all]"


git clone https://github.com/kevin010717/rl-envs-collection.git
cd rl-envs-collection
git submodule add https://github.com/kevin010717/gymnasium.git
git submodule add https://github.com/kevin010717/gymnasium-robotics.git
git commit -m "Add gymnasium and gymnasium-robotics as submodules"
git push origin main

git clone --recurse-submodules https://github.com/kevin010717/rl-envs-collection.git
git clone --recurse-submodules git@github.com:yourname/rl-envs-collection.git
cd rl-envs-collection
# 如果忘了加 --recurse-submodules，可以补：
git submodule update --init --recursive

# 设置 upstream 指向原始仓库
cd Gymnasium
git remote -v    # 看一下现在只有 origin=你的fork
git remote add upstream https://github.com/Farama-Foundation/Gymnasium.git
git remote -v
cd gymnasium-robotics
git remote -v
git remote add upstream https://github.com/Farama-Foundation/gymnasium-robotics.git
git remote -v


