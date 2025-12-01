# Gymnasium 可选环境安装合集
conda create -n gymnasium python=3.11 -y
conda activate gymnasium
git clone --recurse-submodules https://github.com/kevin010717/rl-envs-collection.git
cd rl-envs-collection
pip install -e gymnasium gymnasium-robotics
# 安装所有环境（非常大）
pip install swig
pip install "gymnasium[all]"
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



# 使用 Git 子模块管理 Gymnasium 和 Gymnasium-Robotics
git clone https://github.com/kevin010717/rl-envs-collection.git
cd rl-envs-collection
git submodule add https://github.com/kevin010717/gymnasium.git
git submodule add https://github.com/kevin010717/gymnasium-robotics.git
git submodule add https://github.com/kevin010717/mujoco.git
git submodule add https://github.com/kevin010717/mujoco-learning.git
git submodule add https://github.com/kevin010717/mujoco_learning.git
git commit -m "Add mujoco-learning as submodules"
git push origin main
git add .
git commit -m "1"
git push origin main

# 克隆包含子模块的仓库
git clone --recurse-submodules https://github.com/kevin010717/rl-envs-collection.git
cd rl-envs-collection
git submodule update --init --recursive

# 设置 upstream 指向原始仓库 目前没用到！！！
cd Gymnasium
git remote -v    # 看一下现在只有 origin=你的fork
git remote add upstream https://github.com/Farama-Foundation/Gymnasium.git
git remote -v
cd gymnasium-robotics
git remote -v
git remote add upstream https://github.com/Farama-Foundation/gymnasium-robotics.git
git remote -v
# 同步更新代码
cd Gymnasium
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
cd gymnasium-robotics
git fetch upstream
git checkout main
git merge upstream/main
git push origin main    
# 更新子模块引用
git status   # 会看到 gymnasium 子模块有更新
git add gymnasium
git commit -m "Update gymnasium submodule"
git push origin main

# mujoco-learning
pip install shimmy tensorboard gym stable-baselines3